package cn.maitian.app.library.ui.util;


import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.ui.util
 *
 * @Author: Chris Chen
 * @Time: 2019/4/27 17:15
 * @Description:
 */
public class FragmentUtil {

    public static void replaceFragment (FragmentManager manager, Fragment to, int resId) {
        replaceFragment(manager, null, to, resId, false);
    }

    /**
     * Replace the current fragment
     */
    public static void replaceFragment (FragmentManager manager, Object from, Fragment to, int resId, boolean isToBack) {
        FragmentTransaction transaction = manager.beginTransaction()
//                .setCustomAnimations(R.anim.enter_from_right, R.anim.exit_to_left, R.anim.enter_from_left, R.anim.exit_to_right)
                .setTransition(FragmentTransaction.TRANSIT_FRAGMENT_OPEN);

        if (from == null || from.toString() == null || from.toString() == "") {
            transaction.replace(resId, to);
        } else {
            transaction.replace(resId, to, from.toString());
            if (isToBack) {
                transaction.addToBackStack(null);
            }
        }


        transaction.commit();
    }
}
