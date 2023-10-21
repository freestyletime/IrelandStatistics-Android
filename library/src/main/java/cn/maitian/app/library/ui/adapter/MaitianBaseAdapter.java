package cn.maitian.app.library.ui.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import java.util.ArrayList;
import java.util.List;

import cn.maitian.app.library.ui.item.IItem;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.ui.adapter
 *
 * @Author: Chris Chen
 * @Time: 2019/4/27 11:36
 * @Description:
 */
public final class MaitianBaseAdapter extends BaseAdapter {

    private Context _context;
    private List<IItem> _items;

    public MaitianBaseAdapter (Context context, List<IItem> items) {
        this._context = context;
        this._items = (items == null ? items = new ArrayList<>() : items);
    }

    @Override
    public int getCount () {
        return _items.size();
    }

    @Override
    public Object getItem (int i) {
        return _items.get(i);
    }

    @Override
    public long getItemId (int i) {
        return i;
    }

    @Override
    public View getView (int i, View view, ViewGroup viewGroup) {
        return _items.get(i).getView(_context, view, i);
    }
}