package cn.maitian.app.library.network.http.converter;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;

import java.io.IOException;
import java.lang.reflect.Type;

import cn.maitian.app.library.model.abs.IModel;
import okhttp3.ResponseBody;
import retrofit2.Converter;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.network.http.converter
 *
 * @Author: Chris Chen
 * @Time: 2019/4/18 10:23
 * @Description:
 */
public final class GsonResponseBodyConverter<T extends IModel> implements Converter<ResponseBody, T> {

    private final Gson gson;
    private final Type type;

    GsonResponseBodyConverter (Gson gson, Type type) {
        this.gson = gson;
        this.type = type;
    }

    @Override
    public T convert (ResponseBody value) throws IOException, JsonSyntaxException {
        String response = value.string();
        return gson.fromJson(response, type);
    }
}
