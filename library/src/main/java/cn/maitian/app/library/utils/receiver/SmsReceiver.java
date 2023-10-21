package cn.maitian.app.library.utils.receiver;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Build;
import android.os.Bundle;
import android.telephony.SmsMessage;

import cn.maitian.app.library.utils.log.Log;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.utils.receiver
 *
 * @Author: Chris Chen
 * @Time: 2019/6/14 15:46
 * @Description: action: android.provider.Telephony.SMS_RECEIVED
 */
public class SmsReceiver extends BroadcastReceiver {

    private static final String TAG = SmsReceiver.class.getSimpleName();
    private SmsListener smsListener;

    @Override
    public void onReceive (Context context, Intent intent) {
        try {
            if (Log.isPrint) {
                Log.i(TAG, "收到广播：" + intent.getAction());
                Bundle bundle = intent.getExtras();
                for (String key : bundle.keySet()) {
                    Log.i(TAG, key + " : " + bundle.get(key));
                }
            }
            Object[] pdus = (Object[]) intent.getExtras().get("pdus");
            String fromAddress = null;
            String serviceCenterAddress = null;
            if (pdus != null) {
                String msgBody = "";
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.DONUT) {
                    for (Object obj : pdus) {
                        SmsMessage sms = SmsMessage.createFromPdu((byte[]) obj);
                        msgBody += sms.getMessageBody();
                        fromAddress = sms.getOriginatingAddress();
                        serviceCenterAddress = sms.getServiceCenterAddress();

                        if (smsListener != null) {
                            smsListener.onMessage(sms);
                        }

                        if (Log.isPrint) {
                            Log.i(TAG, "getDisplayMessageBody：" + sms.getDisplayMessageBody());
                            Log.i(TAG, "getDisplayOriginatingAddress：" + sms.getDisplayOriginatingAddress());
                            Log.i(TAG, "getEmailBody：" + sms.getEmailBody());
                            Log.i(TAG, "getEmailFrom：" + sms.getEmailFrom());
                            Log.i(TAG, "getMessageBody：" + sms.getMessageBody());
                            Log.i(TAG, "getOriginatingAddress：" + sms.getOriginatingAddress());
                            Log.i(TAG, "getPseudoSubject：" + sms.getPseudoSubject());
                            Log.i(TAG, "getServiceCenterAddress：" + sms.getServiceCenterAddress());
                            Log.i(TAG, "getIndexOnIcc：" + sms.getIndexOnIcc());
                            Log.i(TAG, "getMessageClass：" + sms.getMessageClass());
                            Log.i(TAG, "getUserData：" + new String(sms.getUserData()));
                        }
                    }
                }
                if (smsListener != null) {
                    smsListener.onMessage(msgBody, fromAddress, serviceCenterAddress);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void registerSmsReceiver (Context context, SmsListener smsListener) {
        try {
            this.smsListener = smsListener;
            IntentFilter filter = new IntentFilter();
            filter.addAction("android.provider.Telephony.SMS_RECEIVED");
            filter.setPriority(Integer.MAX_VALUE);
            context.registerReceiver(this, filter);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void unRegisterSmsReceiver (Context context) {
        try {
            context.unregisterReceiver(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static abstract class SmsListener {
        public abstract void onMessage (String msg, String fromAddress, String serviceCenterAddress);

        public void onMessage (SmsMessage msg) {}
    }
}
