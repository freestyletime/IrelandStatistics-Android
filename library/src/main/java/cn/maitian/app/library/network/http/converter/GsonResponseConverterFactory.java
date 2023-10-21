package cn.maitian.app.library.network.http.converter;

import cn.maitian.app.library.model.abs.IModel;
import com.google.gson.Gson;

import java.lang.annotation.Annotation;
import java.lang.reflect.Type;

import okhttp3.ResponseBody;
import retrofit2.Converter;
import retrofit2.Retrofit;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.network.http.converter
 *
 * @Author: Chris Chen
 * @Time: 2019/4/18 10:24
 * @Description:
 *
 *      You can define your data structure
 */
public final class GsonResponseConverterFactory<T extends IModel> extends Converter.Factory {

    private final Gson _gson;

    public static GsonResponseConverterFactory create () {
        return create(new Gson());
    }

    public static GsonResponseConverterFactory create (Gson gson) {
        return new GsonResponseConverterFactory(gson);
    }

    private GsonResponseConverterFactory (Gson gson) {
        if (gson == null) throw new NullPointerException("gson == null");
        this._gson = gson;
    }

    @Override
    public Converter<ResponseBody, T> responseBodyConverter (Type type, Annotation[] annotations, Retrofit retrofit) {
        return new GsonResponseBodyConverter<>(_gson, type);
    }
}
