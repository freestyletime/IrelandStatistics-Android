package cn.maitian.app.library.ui.adapter;


import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentStatePagerAdapter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.ui.adapter
 *
 * @Author: Chris Chen
 * @Time: 2019/4/27 11:37
 * @Description:
 */
public final class MaitianFragmentPagerAdapter extends FragmentStatePagerAdapter {

    private List<String> _titles;
    private List<Fragment> _fragments;

    public MaitianFragmentPagerAdapter (FragmentManager fm, Map<String, Fragment> datas) {

        super(fm);

        if (datas == null) {
            datas = new HashMap<>();
        }

        Set<Map.Entry<String, Fragment>> entrys = datas.entrySet();
        this._fragments = new ArrayList<>();
        this._titles = new ArrayList<>();

        for (Map.Entry<String, Fragment> entry : entrys) {
            this._titles.add(entry.getKey());
            this._fragments.add(entry.getValue());
        }
    }

    @Override
    public Fragment getItem (int position) {
        return _fragments.get(position);
    }

    @Override
    public int getCount () {
        return _fragments.size();
    }

    @Override
    public CharSequence getPageTitle (int position) {
        if (_titles == null || _titles.size() <= position) {
            return super.getPageTitle(position);
        } else {
            return _titles.get(position);
        }
    }
}
