package cn.maitian.app.library.ui.holder;

import android.view.LayoutInflater;
import android.view.ViewGroup;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.ui.holder
 *
 * @Author: Chris Chen
 * @Time: 2019/4/26 14:43
 * @Description:
 */
public interface AbsHolderFactory {
    AbsViewHolder getHolder (LayoutInflater inflater, ViewGroup viewGroup, int type);
}
