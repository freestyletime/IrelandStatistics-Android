package cn.maitian.app.library.network.http;

import cn.maitian.app.library.event.BaseEvent;
import cn.maitian.app.library.event.BusProvider;
import cn.maitian.app.library.event.IEvent;
import rx.Subscriber;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.network
 *
 * @Author: Chris Chen
 * @Time: 2019/4/14 16:41
 * @Description:
 */
final class HttpObserver extends Subscriber<IEvent> {

    private String _id;
    private HttpExceptionHandler _handler;

    // --------------------------------------------------------------------

    // --------------------------------------------------------------------

    public HttpObserver (String id) {
        this._id = id;
        this._handler = new HttpExceptionHandler();
    }

    @Override
    public void onStart () {
        IEvent event;
        if ((event = this._handler.hasAvailableNetwork(_id)) != null) {
            BusProvider.post(event);
            unsubscribe();
        }
    }

    @Override
    public void onNext (IEvent event) {
        if (event != null) {
            BusProvider.post(event);
        }
    }

    @Override
    public void onCompleted () {
        BusProvider.post(new BaseEvent(_id));
        unsubscribe();
    }

    @Override
    public void onError (Throwable e) {
        BusProvider.post(this._handler.dispatchException(_id, e));
    }

}