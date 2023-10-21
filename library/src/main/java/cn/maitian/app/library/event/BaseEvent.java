package cn.maitian.app.library.event;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.event
 *
 * @Author: Chris Chen
 * @Time: 2019/4/14 16:37
 * @Description:
 */
public class BaseEvent implements IEvent {
    public String id;

    public BaseEvent (String id) {
        this.id = id;
    }
}

