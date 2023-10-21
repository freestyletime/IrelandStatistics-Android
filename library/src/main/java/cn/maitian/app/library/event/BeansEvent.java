package cn.maitian.app.library.event;

import java.util.List;

import cn.maitian.app.library.model.abs.IBean;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.event
 *
 * @Author: Chris Chen
 * @Time: 2019/4/15 9:47
 * @Description:
 */
public class BeansEvent<E extends IBean> extends BaseEvent {

    public List<E> es;

    public BeansEvent (String id, List<E> es) {
        super(id);
        this.es = es;
    }
}
