package cn.maitian.app.library.core;

import java.util.HashMap;

import cn.maitian.app.library.utils.common.StringUtils;
import rx.Subscription;
import rx.subscriptions.CompositeSubscription;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.core
 *
 * @Author: Chris Chen
 * @Time: 2019/6/15 10:25
 * @Description:
 */
public final class SubscriptionManager {

    private final HashMap<String, CompositeSubscription> _subscriptions = new HashMap<>();

    /**
     * Collect the {@link Subscription} by unique id.
     *
     * @param id the unique id of request class
     * @param subscription A Subscription you want to subscribe
     */
    public void collect (String id, Subscription subscription) {
        if (this._subscriptions.get(id) == null) {
            CompositeSubscription cs = new CompositeSubscription();
            this._subscriptions.put(id, cs);
        }

        this._subscriptions.get(id).add(subscription);
    }

    /**
     * Release the {@link Subscription} by unique id.
     *
     * @param id the unique id of request class
     */
    public void release (String id) {
        if(StringUtils.isEmpty(id))return;

        CompositeSubscription cs = this._subscriptions.get(id);
        if (cs != null) {
            if (!cs.isUnsubscribed()) {
                cs.unsubscribe();
            }
            cs.clear();
            this._subscriptions.remove(id);
        }
    }
}
