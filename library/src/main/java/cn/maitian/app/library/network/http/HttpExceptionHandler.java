package cn.maitian.app.library.network.http;

import com.google.gson.JsonSyntaxException;

import java.io.EOFException;
import java.io.InterruptedIOException;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.SocketTimeoutException;
import java.net.UnknownHostException;

import cn.maitian.app.library.LibraryApplication;
import cn.maitian.app.library.ErrorHandler;
import cn.maitian.app.library.event.FEvent;
import cn.maitian.app.library.event.IEvent;
import cn.maitian.app.library.utils.assist.NetChecker;
import retrofit2.adapter.rxjava.HttpException;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.network.http
 *
 * @Author: Chris Chen
 * @Time: 2019/4/15 10:59
 * @Description: To deal with the http public errors.
 */
public class HttpExceptionHandler {

    public HttpExceptionHandler () {
    }

    public IEvent hasAvailableNetwork (String id) {
        if (!NetChecker.isConnected(LibraryApplication.getInstance())) {
            return new FEvent(id, FEvent.TYPE.L, 0, ErrorHandler.EMS.get(0));
        }
        return null;
    }

    public IEvent dispatchException (String id, Throwable e) {

        IEvent event;

        if (e instanceof HttpException) {
            HttpException httpException = (HttpException) e;
            int statusCode = httpException.code();
            switch (statusCode) {
                case HttpURLConnection.HTTP_BAD_REQUEST:
                    event = new FEvent(id, FEvent.TYPE.L, 6, ErrorHandler.EMS.get(6));
                    break;
                case HttpURLConnection.HTTP_UNAUTHORIZED:
                case HttpURLConnection.HTTP_FORBIDDEN:
                    event = new FEvent(id, FEvent.TYPE.L, 12, ErrorHandler.EMS.get(12));
                    break;
                case HttpURLConnection.HTTP_CLIENT_TIMEOUT:
                    event = new FEvent(id, FEvent.TYPE.L, 13, ErrorHandler.EMS.get(13));
                    break;
                case HttpURLConnection.HTTP_GATEWAY_TIMEOUT:
                    event = new FEvent(id, FEvent.TYPE.L, 14, ErrorHandler.EMS.get(14));
                    break;
                case HttpURLConnection.HTTP_NOT_FOUND:
                case HttpURLConnection.HTTP_INTERNAL_ERROR:
                case HttpURLConnection.HTTP_BAD_GATEWAY:
                case HttpURLConnection.HTTP_UNAVAILABLE:
                    event = new FEvent(id, FEvent.TYPE.L, 3, ErrorHandler.EMS.get(3));
                    break;
                default:
                    if (statusCode >= 300 && statusCode <= 499) {
                        event = new FEvent(id, FEvent.TYPE.L, 2, ErrorHandler.EMS.get(2));
                    } else if (statusCode >= 500 && statusCode <= 599) {
                        event = new FEvent(id, FEvent.TYPE.L, 3, ErrorHandler.EMS.get(3));
                    } else {
                        event = new FEvent(id, FEvent.TYPE.L, 4, ErrorHandler.EMS.get(4));
                    }
                    break;
            }
        } else if (e instanceof JsonSyntaxException) {
            event = new FEvent(id, FEvent.TYPE.L, 10, ErrorHandler.EMS.get(10));
        } else if (e instanceof UnknownHostException) {
            event = new FEvent(id, FEvent.TYPE.L, 8, ErrorHandler.EMS.get(8));
        } else if (e instanceof EOFException) {
            event = new FEvent(id, FEvent.TYPE.L, 5, ErrorHandler.EMS.get(5));
        } else if (e instanceof SocketTimeoutException) {
            event = new FEvent(id, FEvent.TYPE.L, 9, ErrorHandler.EMS.get(9));
        } else if (e instanceof InterruptedIOException) {
            event = new FEvent(id, FEvent.TYPE.L, 7, ErrorHandler.EMS.get(7));
        } else if (e instanceof ConnectException) {
            event = new FEvent(id, FEvent.TYPE.L, 11, ErrorHandler.EMS.get(11));
        } else {
            event = new FEvent(id, FEvent.TYPE.L, 1, ErrorHandler.EMS.get(1));
        }
        return event;
    }
}