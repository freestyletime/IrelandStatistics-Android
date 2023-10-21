package cn.maitian.app.library.utils.assist;


/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.utils.assist
 *
 * @Author: Chris Chen
 * @Time: 2019/6/6 16:42
 * @Description:
 */
public class TimeAverager {
    /**
     * 计时器
     */
    private TimeCounter tc = new TimeCounter();
    /**
     * 均值器
     */
    private Averager av = new Averager();

    /**
     * 一个计时开始
     */
    public long start () {
        return tc.start();
    }

    /**
     * 一个计时结束
     */
    public long end () {
        long time = tc.duration();
        av.add(time);
        return time;
    }

    /**
     * 一个计时结束,并且启动下次计时。
     */
    public long endAndRestart () {
        long time = tc.durationRestart();
        av.add(time);
        return time;
    }

    /**
     * 求全部计时均值
     */
    public Number average () {
        return av.getAverage();
    }

    /**
     * 打印全部时间值
     */
    public void print () {
        av.print();
    }

    /**
     * 清楚数据
     */
    public void clear () {
        av.clear();
    }
}
