package cn.maitian.app.library.utils.data.cipher;


import cn.maitian.app.library.utils.assist.Base64;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.utils.data.cipher
 *
 * @Author: Chris Chen
 * @Time: 2019/6/3 14:50
 * @Description:
 */
public class Base64Cipher extends Cipher {
    private Cipher cipher;

    public Base64Cipher () {
    }

    public Base64Cipher (Cipher cipher) {
        this.cipher = cipher;
    }

    @Override
    public byte[] decrypt (byte[] res) {
        if (cipher != null) res = cipher.decrypt(res);
        return Base64.decode(res, Base64.DEFAULT);
    }

    @Override
    public byte[] encrypt (byte[] res) {
        if (cipher != null) res = cipher.encrypt(res);
        return Base64.encode(res, Base64.DEFAULT);
    }
}
