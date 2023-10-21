package cn.maitian.app.library.event;

import cn.maitian.app.library.model.abs.IBean;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.event
 *
 * @Author: Chris Chen
 * @Time: 2019/4/15 9:47
 * @Description:
 */
public class BeanEvent<E extends IBean> extends BaseEvent {

    public E e;

    public BeanEvent (String id, E e) {
        super(id);
        this.e = e;
    }
}
