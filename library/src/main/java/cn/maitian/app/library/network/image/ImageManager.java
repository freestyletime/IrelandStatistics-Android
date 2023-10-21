package cn.maitian.app.library.network.image;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.webkit.URLUtil;
import android.widget.ImageView;
import cn.maitian.app.library.utils.common.StringUtils;
import com.bumptech.glide.Glide;
import com.bumptech.glide.GlideBuilder;
import com.bumptech.glide.load.resource.bitmap.BitmapTransformation;
import com.bumptech.glide.module.GlideModule;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.network.image
 *
 * @Author: Chris Chen
 * @Time: 2019/4/19 16:40
 * @Description:
 */
public class ImageManager {

    protected Glide glide;

    public ImageManager (Context context, String cachePath, boolean hQulity) {
        GlideBuilder builder = new GlideBuilder(context.getApplicationContext());
        GlideModule module = new ImageStrategyModule(cachePath, hQulity);
        module.applyOptions(context.getApplicationContext(), builder);

        glide.setup(builder);
        glide = glide.get(context.getApplicationContext());
    }

    /**
     * Return the instance of glide.
     */
    public Glide getGlide () {
        return glide;
    }

    /**
     * Load image from URL to {@link ImageView}
     *
     * @param context current context environmnet
     * @param url     the URL of image
     * @param view    the object of ImageView
     */
    public void toImage (Context context, String url, ImageView view) {
        if (context != null && !StringUtils.isEmpty(url) && URLUtil.isNetworkUrl(url) && view != null) {
            glide.with(context.getApplicationContext()).load(url).centerCrop().crossFade().into(view);
        }
    }

    /***
     * 加载本地图片
     *
     * @param context
     * @param url
     * @param view
     */
    public void toLocalImage (Context context, String url, ImageView view) {
        if (context != null && !StringUtils.isEmpty(url) && view != null) {
            glide.with(context.getApplicationContext()).load(url).asBitmap().into(view);
        }
    }

    /**
     * Load image from URL to {@link ImageView}
     *
     * @param context        current context environmnet
     * @param url            the URL of image
     * @param view           the object of ImageView
     * @param transformation image transform
     */
    public void toImage (Context context, String url, ImageView view, BitmapTransformation transformation) {
        if (context != null && !StringUtils.isEmpty(url) && URLUtil.isNetworkUrl(url) && view != null) {
            glide.with(context.getApplicationContext()).load(url).centerCrop().crossFade().transform(transformation).into(view);
        }
    }

    /**
     * Load image from URL to {@link ImageView}
     *
     * @param context   current context environmnet
     * @param url       the URL of image
     * @param view      the object of ImageView
     * @param defaultId default image resource id
     */
    public void toImage (Context context, String url, ImageView view, int defaultId) {
        if (context != null && !StringUtils.isEmpty(url) && URLUtil.isNetworkUrl(url) && view != null) {
            glide.with(context.getApplicationContext()).load(url).centerCrop().placeholder(defaultId).crossFade().into(view);
        }
    }

    /**
     * Load image from URL to {@link ImageView}
     *
     * @param context        current context environmnet
     * @param url            the URL of image
     * @param view           the object of ImageView
     * @param defaultId      default image resource id
     * @param transformation image transform
     */
    public void toImage (Context context, String url, ImageView view, int defaultId, BitmapTransformation transformation) {
        if (context != null && !StringUtils.isEmpty(url) && URLUtil.isNetworkUrl(url) && view != null) {
            glide.with(context.getApplicationContext()).load(url).centerCrop().placeholder(defaultId).crossFade().transform(transformation).into(view);
        }
    }

    /**
     * Load image from URL to {@link ImageView}
     *
     * @param context   current context environmnet
     * @param url       the URL of image
     * @param view      the object of ImageView
     * @param defaultId default image resource id
     * @param errorId   error image resource id
     */
    public void toImage (Context context, String url, ImageView view, int defaultId, int errorId) {
        if (context != null && !StringUtils.isEmpty(url) && URLUtil.isNetworkUrl(url) && view != null) {
            glide.with(context.getApplicationContext()).load(url).centerCrop().placeholder(defaultId).error(errorId).crossFade().into(view);
        }
    }

    /**
     * Load image from URL to {@link ImageView}
     *
     * @param context         current context environmnet
     * @param url             the URL of image
     * @param view            the object of ImageView
     * @param defaultDrawable default drawable to show
     */
    public void toImage (Context context, String url, ImageView view, Drawable defaultDrawable) {
        if (context != null && !StringUtils.isEmpty(url) && URLUtil.isNetworkUrl(url) && view != null) {
            glide.with(context.getApplicationContext()).load(url).centerCrop().placeholder(defaultDrawable).crossFade().into(view);
        }
    }

    /**
     * Load image from URL to {@link ImageView}
     *
     * @param context         current context environmnet
     * @param url             the URL of image
     * @param view            the object of ImageView
     * @param defaultDrawable default drawable to show
     * @param errorDrawable   error drawable to show
     */
    public void toImage (Context context, String url, ImageView view, Drawable defaultDrawable, Drawable errorDrawable) {
        if (context != null && !StringUtils.isEmpty(url) && URLUtil.isNetworkUrl(url) && view != null) {
            glide.with(context.getApplicationContext()).load(url).centerCrop().placeholder(defaultDrawable).error(errorDrawable).crossFade().into(view);
        }
    }

    /**
     * Load gif from URL to {@link ImageView}
     *
     * @param context current context environmnet
     * @param url     the URL of gif
     * @param view    the object of ImageView
     */
    public void toGif (Context context, String url, ImageView view) {
        if (context != null && !StringUtils.isEmpty(url) && URLUtil.isNetworkUrl(url) && view != null) {
            glide.with(context.getApplicationContext()).load(url).asGif().crossFade().into(view);
        }
    }

    /**
     * Load gif from URL to {@link ImageView}
     *
     * @param context   current context environmnet
     * @param url       the URL of gif
     * @param view      the object of ImageView
     * @param defaultId default image resource id
     */
    public void toGif (Context context, String url, ImageView view, int defaultId) {
        if (context != null && !StringUtils.isEmpty(url) && URLUtil.isNetworkUrl(url) && view != null) {
            glide.with(context.getApplicationContext()).load(url).asGif().placeholder(defaultId).crossFade().into(view);
        }
    }

    /**
     * Load gif from URL to {@link ImageView}
     *
     * @param context   current context environmnet
     * @param url       the URL of gif
     * @param view      the object of ImageView
     * @param defaultId default image resource id
     * @param errorId   error image resource id
     */
    public void toGif (Context context, String url, ImageView view, int defaultId, int errorId) {
        if (context != null && !StringUtils.isEmpty(url) && URLUtil.isNetworkUrl(url) && view != null) {
            glide.with(context.getApplicationContext()).load(url).asGif().placeholder(defaultId).error(errorId).crossFade().into(view);
        }
    }

    /**
     * Load gif from URL to {@link ImageView}
     *
     * @param context         current context environmnet
     * @param url             the URL of gif
     * @param view            the object of ImageView
     * @param defaultDrawable default drawable to show
     */
    public void toGif (Context context, String url, ImageView view, Drawable defaultDrawable) {
        if (context != null && !StringUtils.isEmpty(url) && URLUtil.isNetworkUrl(url) && view != null) {
            glide.with(context.getApplicationContext()).load(url).asGif().placeholder(defaultDrawable).crossFade().into(view);
        }
    }

    /**
     * Load gif from URL to {@link ImageView}
     *
     * @param context         current context environmnet
     * @param url             the URL of gif
     * @param view            the object of ImageView
     * @param defaultDrawable default drawable to show
     * @param errorDrawable   error drawable to show
     */
    public void toGif (Context context, String url, ImageView view, Drawable defaultDrawable, Drawable errorDrawable) {
        if (context != null && !StringUtils.isEmpty(url) && URLUtil.isNetworkUrl(url) && view != null) {
            glide.with(context.getApplicationContext()).load(url).asGif().placeholder(defaultDrawable).error(errorDrawable).crossFade().into(view);
        }
    }
}
