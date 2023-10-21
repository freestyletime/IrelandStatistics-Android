package cn.maitian.app.library.utils.io;

import android.os.Build;

import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.utils.io
 *
 * @Author: Chris Chen
 * @Time: 2019/6/1 10:21
 * @Description:
 */
public class StringCodingUtils {

    public static byte[] getBytes (String src, Charset charSet) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.GINGERBREAD) {
            try {
                return src.getBytes(charSet.name());
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            return null;
        } else {
            return src.getBytes(charSet);
        }
    }

}
