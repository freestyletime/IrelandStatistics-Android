package cn.maitian.app.library.utils.common;

import android.os.Handler;
import android.os.Looper;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.utils.common
 *
 * @Author: Chris Chen
 * @Time: 2019/6/3 14:10
 * @Description:
 */
public class HandlerUtil {
    public static final Handler HANDLER = new Handler(Looper.getMainLooper());

    public static void runOnUiThread (Runnable runnable) {
        HANDLER.post(runnable);
    }

    public static void runOnUiThreadDelay (Runnable runnable, long delayMillis) {
        HANDLER.postDelayed(runnable, delayMillis);
    }

    public static void removeRunable (Runnable runnable) {
        HANDLER.removeCallbacks(runnable);
    }
}
