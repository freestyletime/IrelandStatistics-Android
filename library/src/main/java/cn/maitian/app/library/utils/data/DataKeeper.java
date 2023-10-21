package cn.maitian.app.library.utils.data;

import android.content.Context;
import android.content.SharedPreferences;

import cn.maitian.app.library.utils.common.ByteUtil;
import cn.maitian.app.library.utils.common.HexUtil;
import cn.maitian.app.library.utils.data.cipher.Cipher;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.ui.view
 *
 * @Author: Chris Chen
 * @Time: 2019/6/6 15:23
 * @Description:
 */
public class DataKeeper {

    private SharedPreferences sp;

    public DataKeeper (Context context, String fileName) {
        sp = context.getSharedPreferences(fileName, Context.MODE_PRIVATE);
    }

    /**
     * *************** get ******************
     */

    public String get (String key, String defValue) {
        return sp.getString(key, defValue);
    }

    public boolean get (String key, boolean defValue) {
        return sp.getBoolean(key, defValue);
    }

    public float get (String key, float defValue) {
        return sp.getFloat(key, defValue);
    }

    public int getInt (String key, int defValue) {
        return sp.getInt(key, defValue);
    }

    public long get (String key, long defValue) {
        return sp.getLong(key, defValue);
    }

    public Object get (String key) {
        return get(key, (Cipher) null);
    }

    public Object get (String key, Cipher cipher) {
        try {
            String hex = get(key, (String) null);
            if (hex == null) return null;
            byte[] bytes = HexUtil.decodeHex(hex.toCharArray());
            if (cipher != null) bytes = cipher.decrypt(bytes);
            Object obj = ByteUtil.byteToObject(bytes);
            return obj;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * *************** put ******************
     */
    public void put (String key, Object ser) {
        put(key, ser, null);
    }

    public void put (String key, Object ser, Cipher cipher) {
        try {
            if (ser == null) {
                sp.edit().remove(key).commit();
            } else {
                byte[] bytes = ByteUtil.objectToByte(ser);
                if (cipher != null) bytes = cipher.encrypt(bytes);
                put(key, HexUtil.encodeHexStr(bytes));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void put (String key, String value) {
        if (value == null) {
            sp.edit().remove(key).commit();
        } else {
            sp.edit().putString(key, value).commit();
        }
    }

    public void put (String key, boolean value) {
        sp.edit().putBoolean(key, value).commit();
    }

    public void put (String key, float value) {
        sp.edit().putFloat(key, value).commit();
    }

    public void put (String key, long value) {
        sp.edit().putLong(key, value).commit();
    }

    public void putInt (String key, int value) {
        sp.edit().putInt(key, value).commit();
    }

}
