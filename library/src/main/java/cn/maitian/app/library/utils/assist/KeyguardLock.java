package cn.maitian.app.library.utils.assist;

import android.app.KeyguardManager;
import android.content.Context;
import android.os.Build;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.utils.assist
 *
 * @Author: Chris Chen
 * @Time: 2019/6/6 10:26
 * @Description:
 */
public class KeyguardLock {
    KeyguardManager keyguardManager;
    KeyguardManager.KeyguardLock keyguardLock;

    public KeyguardLock (Context context, String tag) {
        keyguardManager = (KeyguardManager) context.getSystemService(Context.KEYGUARD_SERVICE);
        keyguardLock = keyguardManager.newKeyguardLock(tag);
    }

    /**
     * Call requires API level 16
     */
    public boolean isKeyguardLocked () {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.JELLY_BEAN) {
            return false;
        } else {
            return keyguardManager.isKeyguardLocked();
        }

    }

    /**
     * Call requires API level 16
     */
    public boolean isKeyguardSecure () {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.JELLY_BEAN) {
            return false;
        } else {
            return keyguardManager.isKeyguardSecure();
        }
    }

    public boolean inKeyguardRestrictedInputMode () {
        return keyguardManager.inKeyguardRestrictedInputMode();
    }

    public void disableKeyguard () {
        keyguardLock.disableKeyguard();
    }

    public void reenableKeyguard () {
        keyguardLock.reenableKeyguard();
    }

    public void release () {
        if (keyguardLock != null) {
            keyguardLock.reenableKeyguard();
        }
    }

    public KeyguardManager getKeyguardManager () {
        return keyguardManager;
    }

    public void setKeyguardManager (KeyguardManager keyguardManager) {
        this.keyguardManager = keyguardManager;
    }

    public KeyguardManager.KeyguardLock getKeyguardLock () {
        return keyguardLock;
    }

    public void setKeyguardLock (KeyguardManager.KeyguardLock keyguardLock) {
        this.keyguardLock = keyguardLock;
    }
}
