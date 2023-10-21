package cn.maitian.app.library.ui.item;

import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

import cn.maitian.app.library.model.abs.IBean;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.ui.item
 *
 * @Author: Chris Chen
 * @Time: 2019/4/26 14:15
 * @Description:
 */
public abstract class AbsItemFactory {

    public abstract <T extends IBean> IItem getItem (T t, int... args);

    public <T extends IBean> List<IItem> getItem (List<T> ts, int... args) {
        if (ts == null || ts.size() == 0) {
            return Collections.emptyList();
        }

        List<IItem> items = new LinkedList<>();

        for (T t : ts) {
            items.add(getItem(t, args));
        }

        return items;
    }
}
