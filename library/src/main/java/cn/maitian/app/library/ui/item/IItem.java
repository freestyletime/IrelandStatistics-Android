package cn.maitian.app.library.ui.item;

import android.content.Context;
import android.view.View;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.ui.item
 *
 * @Author: Chris Chen
 * @Time: 2019/4/26 14:14
 * @Description:
 */
public interface IItem {
    View getView (Context context, View view, int Position);
}
