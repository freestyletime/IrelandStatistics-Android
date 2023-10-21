package cn.maitian.app.library.ui.util;

import android.content.Context;
import android.widget.Toast;

/**
 * Created by IntelliJ IDEA in Maitian
 * cn.maitian.app.core
 *
 * @Author: Chris Chen
 * @Time: 2019/8/12 15:54
 * @Description:
 */
public class ToastBuilder {
    public static void buildDefaultShortToast (Context context, String content) {
        Toast.makeText(context, content, Toast.LENGTH_SHORT).show();
    }

    public static void buildDefaultLongToast (Context context, String content) {
        Toast.makeText(context, content, Toast.LENGTH_LONG).show();
    }
}