package cn.maitian.app.library.event;

import com.squareup.otto.Bus;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.event
 *
 * @Author: Chris Chen
 * @Time: 2019/4/14 16:27
 * @Description:
 */
public class BusProvider {
    private static Bus _bus = new Bus();

    private BusProvider () {
    }

    public static <T extends IEvent> void post (T t) {
        _bus.post(t);
    }

    public static void register (Object obj) {
        _bus.register(obj);
    }

    public static void unregister (Object obj) {
        _bus.unregister(obj);
    }
}
