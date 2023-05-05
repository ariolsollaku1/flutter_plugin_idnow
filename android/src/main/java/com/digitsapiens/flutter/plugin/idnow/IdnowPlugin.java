package com.digitsapiens.flutter.plugin.idnow;

import android.app.Activity;
import android.util.Log;

import androidx.annotation.NonNull;

import de.idnow.core.IDnowConfig;
import de.idnow.core.IDnowResult;
import de.idnow.core.IDnowSDK;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** IdnowPlugin */
public class IdnowPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private static String TAG = "IDNOW";
  private Activity activity;
  private IDnowSDK idnowSdk;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "idnow");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } if(call.method.equals("startIdentification")){
      IDnowConfig idnowConfig = IDnowConfig.Builder.getInstance()
              .withLanguage("en") // this line is not necessary, please see below
              .build();

      idnowSdk = IDnowSDK.getInstance();
      idnowSdk.initialize(this.activity, idnowConfig);

      String identId = call.argument("code").toString(); //"TST-ZFSMN";
      Log.d(TAG, identId);
      idnowSdk.startIdent(identId, new IDnowSDK.IDnowResultListener() {
        @Override
        public void onIdentResult(IDnowResult iDnowResult) {
          if (iDnowResult.getResultType() == IDnowResult.ResultType.FINISHED) {
            Log.d(TAG, "Finished");
            result.success(iDnowResult.getResultType().toString());
          } else if (iDnowResult.getResultType() == IDnowResult.ResultType.CANCELLED) {
            Log.d(TAG, "Cancelled: " + iDnowResult.getStatusCode());
            result.success(iDnowResult.getResultType().toString());
          } else if (iDnowResult.getResultType() == IDnowResult.ResultType.ERROR) {
            Log.d(TAG, "Error: " + iDnowResult.getMessage());
            result.success(iDnowResult.getMessage());
          }
        }
      });
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {

  }
}
