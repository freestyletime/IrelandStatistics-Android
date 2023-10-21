package cn.maitian.app.library.network.http;

import android.text.TextUtils;
import android.webkit.URLUtil;

import com.facebook.stetho.okhttp3.StethoInterceptor;

import java.util.Map;
import java.util.concurrent.TimeUnit;

import cn.maitian.app.library.model.BaseModel;
import okhttp3.OkHttpClient;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Retrofit;
import retrofit2.adapter.rxjava.RxJavaCallAdapterFactory;
import retrofit2.converter.gson.GsonConverterFactory;
import rx.Observable;
import rx.Subscription;
import rx.android.schedulers.AndroidSchedulers;
import rx.schedulers.Schedulers;


/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.network.http
 *
 * @Author: Chris Chen
 * @Time: 2019/4/13 13:53
 * @Description:
 */
public final class HttpManager {

    private OkHttpClient _createClient (Map<String, String> headers, boolean debug) {
        HttpLoggingInterceptor logInterceptor = new HttpLoggingInterceptor();

        OkHttpClient.Builder builder = new OkHttpClient.Builder();
        builder.addInterceptor(new HttpInterceptor(headers));
        builder.connectTimeout(10, TimeUnit.SECONDS);

        if (debug) {
            logInterceptor.setLevel(HttpLoggingInterceptor.Level.BODY);
            builder.networkInterceptors().add(new StethoInterceptor());
            builder.addInterceptor(logInterceptor);
        }

        return builder.build();
    }

    // --------------------------------------------------------------------

    private static class Singleton {
        static final HttpManager INSTANCE = new HttpManager();
    }

    public static HttpManager getInstance () {
        return Singleton.INSTANCE;
    }

    // --------------------------------------------------------------------

    /**
     * Create a new proxy service class for user
     *
     * @param clazz   the class you want to create
     * @param headers the http headers you want to pass will be took at every time of request
     * @param baseURL the basic URL for http request (just like - http://www.google.cn/)
     * @param debug   show the debug log if it is true
     * @return A object of class you pass
     */
    public <T> T createService (Class<T> clazz, Map<String, String> headers, String baseURL, boolean debug) {

        if (TextUtils.isEmpty(baseURL)) {
            throw new IllegalArgumentException("HttpManager::createService >>> baseURL can not be empty");
        }

        if (!URLUtil.isHttpUrl(baseURL)) {
            throw new IllegalArgumentException("HttpManager::createService >>> baseURL is invalid");
        }

        if (clazz == null) {
            throw new IllegalArgumentException("HttpManager::createService >>> clazz can not pass null");
        }

        Retrofit.Builder builder = new Retrofit.Builder()
                .addCallAdapterFactory(RxJavaCallAdapterFactory.create())
                .addConverterFactory(GsonConverterFactory.create())
                .baseUrl(baseURL);

        builder.client(_createClient(headers, debug));

        return builder.build().create(clazz);
    }

    /**
     * Dispatch the response object {@link Observable} to the request class
     *
     * @param id the unique id of request class
     * @param ob the response object
     * @return A Subscription you can cancal your request by it
     * @see {@link cn.maitian.app.library.event.BusProvider}
     */
    public <E extends BaseModel> Subscription dispatch (String id, Observable<E> ob) {

        if (TextUtils.isEmpty(id)) {
            throw new IllegalArgumentException("HttpManager::dispatch >>> id can not be empty");
        }

        if (ob == null) {
            throw new IllegalArgumentException("HttpManager::dispatch >>> observable can not pass null");
        } else {
            return ob
                    .map(new HttpResultFunc<>(id))
                    .subscribeOn(Schedulers.io())
                    .unsubscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe(new HttpObserver(id));
        }
    }
}
