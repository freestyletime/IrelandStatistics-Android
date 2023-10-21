package cn.maitian.app.library.utils.assist;

import java.util.Collection;
import java.util.Map;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.utils.assist
 *
 * @Author: Chris Chen
 * @Time: 2019/6/7 11:41
 * @Description:
 */
public class Check {

    public static boolean isEmpty (CharSequence str) {
        return isNull(str) || str.length() == 0;
    }

    public static boolean isEmpty (Object[] os) {
        return isNull(os) || os.length == 0;
    }

    public static boolean isEmpty (Collection<?> l) {
        return isNull(l) || l.isEmpty();
    }

    public static boolean isEmpty (Map<?, ?> m) {
        return isNull(m) || m.isEmpty();
    }

    public static boolean isNull (Object o) {
        return o == null;
    }
}
