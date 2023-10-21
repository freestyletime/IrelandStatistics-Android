package cn.maitian.app.library.ui.adapter;

import android.os.Parcelable;
import android.view.View;
import android.view.ViewGroup;

import androidx.viewpager.widget.PagerAdapter;

import java.util.List;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.ui.adapter
 *
 * @Author: Chris Chen
 * @Time: 2019/4/27 11:51
 * @Description:
 */
public final class MaitianPagerAdapter extends PagerAdapter {

    private List<View> _layouts;

    public MaitianPagerAdapter (List<View> layouts) {
        this._layouts = layouts;
    }

    @Override
    public void startUpdate (ViewGroup container) {
    }

    @Override
    public void finishUpdate (ViewGroup container) {
    }

    @Override
    public int getCount () {
        return _layouts.size();
    }

    @Override
    public Object instantiateItem (ViewGroup container, int position) {
        container.addView(_layouts.get(position), 0);
        return _layouts.get(position);
    }

    @Override
    public void destroyItem (ViewGroup container, int position, Object object) {
        container.removeView(_layouts.get(position));
    }

    @Override
    public boolean isViewFromObject (View arg0, Object arg1) {
        return arg0 == (arg1);
    }

    @Override
    public void restoreState (Parcelable arg0, ClassLoader arg1) {
    }

    @Override
    public Parcelable saveState () {
        return null;
    }
}
