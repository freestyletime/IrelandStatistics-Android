package ie.chrischen.library.net

import android.text.TextUtils
import android.webkit.URLUtil
import com.facebook.stetho.okhttp3.StethoInterceptor
import ie.chrischen.library.bean.BaseModel
import ie.chrischen.library.bean.abs.IBean
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.schedulers.Schedulers
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import org.reactivestreams.Subscription
import retrofit2.Retrofit
import retrofit2.adapter.rxjava3.RxJava3CallAdapterFactory
import retrofit2.converter.moshi.MoshiConverterFactory
import java.util.concurrent.TimeUnit

object HttpManager {

    private fun _createClient(headers: Map<String, String>?, debug: Boolean): OkHttpClient? {
        val logInterceptor = HttpLoggingInterceptor()

        val builder = OkHttpClient.Builder()
        builder.addInterceptor(if (headers.isNullOrEmpty()) HttpInterceptor() else HttpInterceptor(headers))
        builder.connectTimeout(10, TimeUnit.SECONDS)
        if (debug) {
            logInterceptor.setLevel(HttpLoggingInterceptor.Level.BODY)
            builder.networkInterceptors().add(StethoInterceptor())
            builder.addInterceptor(logInterceptor)
        }
        return builder.build()
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
    fun <T> createService(
        clazz: Class<T>?,
        headers: Map<String, String>?,
        baseURL: String,
        debug: Boolean
    ): T {
        require(!TextUtils.isEmpty(baseURL)) { "HttpManager::createService >>> baseURL can not be empty" }
        require(URLUtil.isHttpUrl(baseURL)) { "HttpManager::createService >>> baseURL is invalid" }
        requireNotNull(clazz) { "HttpManager::createService >>> clazz can not pass null" }
        val builder = Retrofit.Builder()
            .addCallAdapterFactory(RxJava3CallAdapterFactory.create())
            .addConverterFactory(MoshiConverterFactory.create())
            .baseUrl(baseURL)
        _createClient(headers, debug)?.let { builder.client(it) }
        return builder.build().create(clazz)
    }

    /**
     * Dispatch the response object [Observable] to the request class
     *
     * @param id the unique id of request class
     * @param ob the response object
     * @return A Subscription you can cancal your request by it
     * @see {@link cn.maitian.app.library.event.BusProvider}
     */
    fun <T: IBean, E : BaseModel<T>> dispatch(id: String, ob: Observable<E>?) {
        require(id.isNotEmpty()) { "HttpManager::dispatch >>> id can not be empty" }
        return if (ob == null) {
            throw IllegalArgumentException("HttpManager::dispatch >>> observable can not pass null")
        } else {
            ob
                .map(HttpResultFunction(id))
                .subscribeOn(Schedulers.io())
                .unsubscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(HttpObserver(id))
        }
    }
}