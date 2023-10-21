package cn.maitian.app.library.core;

import android.app.Activity;

import java.util.Stack;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.core
 *
 * @Author: Chris Chen
 * @Time: 2019/4/19 15:54
 * @Description: Activities' stack manager
 */
public final class ActivitiesManager {

    private static ActivitiesManager _instance;
    private static Stack<Activity> _activityStack;

    private ActivitiesManager () {
    }

    public static ActivitiesManager getAppManager () {
        if (_instance == null) {
            _instance = new ActivitiesManager();
        }
        return _instance;
    }

    public void addActivity (Activity activity) {
        if (_activityStack == null) {
            _activityStack = new Stack<>();
        }
        _activityStack.add(activity);
    }

    public void removeActivity (Activity activity) {
        if (_activityStack.contains(activity))
            _activityStack.remove(activity);
    }

    public void removeAllActivity () {
        _activityStack.removeAllElements();
    }

    public Activity currentActivity () {
        Activity activity = _activityStack.lastElement();
        return activity;
    }

    public void finishActivity () {
        Activity activity = _activityStack.lastElement();
        finishActivity(activity);
    }

    public void finishActivity (Activity activity) {
        if (activity != null) {
            _activityStack.remove(activity);
            activity.finish();
        }
    }

    public void finishActivity (Class<?> cls) {
        for (Activity activity : _activityStack) {
            if (activity.getClass().equals(cls)) {
                finishActivity(activity);
            }
        }
    }

    public void finishAllActivity () {
        for (int i = 0, size = _activityStack.size(); i < size; i++) {
            if (null != _activityStack.get(i)) {
                _activityStack.get(i).finish();
            }
        }
        _activityStack.clear();
    }

    public void appExit () {
        try {
            finishAllActivity();
            System.exit(0);
        } catch (Exception e) {
        }
    }
}
