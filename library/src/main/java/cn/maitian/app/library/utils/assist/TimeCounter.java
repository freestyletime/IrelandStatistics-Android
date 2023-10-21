package cn.maitian.app.library.utils.assist;

import cn.maitian.app.library.utils.log.Log;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.utils.assist
 *
 * @Author: Chris Chen
 * @Time: 2019/6/6 16:50
 * @Description:
 */
public class TimeCounter {

    private static final String TAG = TimeCounter.class.getSimpleName();
    private long t;

    public TimeCounter () {
        start();
    }

    /**
     * Count start.
     */
    public long start () {
        t = System.currentTimeMillis();
        return t;
    }

    /**
     * Get duration and restart.
     */
    public long durationRestart () {
        long now = System.currentTimeMillis();
        long d = now - t;
        t = now;
        return d;
    }

    /**
     * Get duration.
     */
    public long duration () {
        return System.currentTimeMillis() - t;
    }

    /**
     * Print duration.
     */
    public void printDuration (String tag) {
        Log.i(TAG, tag + " :  " + duration());
    }

    /**
     * Print duration.
     */
    public void printDurationRestart (String tag) {
        Log.i(TAG, tag + " :  " + durationRestart());
    }
}