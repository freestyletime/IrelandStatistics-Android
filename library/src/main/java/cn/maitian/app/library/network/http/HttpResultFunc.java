package cn.maitian.app.library.network.http;

import cn.maitian.app.library.event.*;
import cn.maitian.app.library.model.BaseMultiModel;
import cn.maitian.app.library.model.BaseModel;
import cn.maitian.app.library.model.BaseSingleModel;
import rx.functions.Func1;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.network.http
 *
 * @Author: Chris Chen
 * @Time: 2019/4/15 10:29
 * @Description:
 */
final class HttpResultFunc<E extends BaseModel> implements Func1<E, IEvent> {

    private String _id;

    public HttpResultFunc (String id) {
        this._id = id;
    }

    @Override
    public IEvent call (E e) {

        IEvent event;

        if (e.success) {
            if (e instanceof BaseSingleModel) {
                BaseSingleModel bsm = (BaseSingleModel) e;
                event = new BeanEvent<>(this._id, bsm.pager);
            } else if (e instanceof BaseMultiModel) {
                BaseMultiModel blm = (BaseMultiModel) e;
                event = new BeansEvent<>(this._id, blm.pager);
            } else {
                event = new SEvent(this._id);
            }
        }else{
            event = new FEvent(this._id, FEvent.TYPE.B, 0, e.msg);
        }
        return event;
    }
}
