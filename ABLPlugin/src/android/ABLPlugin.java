package cordova.plugin.abl;

import org.apache.cordova.CordovaPlugin;

import org.apache.cordova.CallbackContext;

import android.content.Context;
import android.content.Intent;

import androidx.annotation.Nullable;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * This class echoes a string called from JavaScript.
 */
public class ABLPlugin extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("startFlow")) {

            // String message = args.getString(0);

            this.startFlow(callbackContext);
            return true;
        }
        return false;
    }

    private void startFlow(CallbackContext callbackContext) {
        Context context = cordova.getActivity().getApplicationContext();
        Intent intent = new Intent(context, CNIC_Availability.class);
        cordova.setActivityResultCallback(this);
        this.cordova.getActivity().startActivityForResult(intent, 22);

    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        if (requestCode == 22 && resultCode == 200 && data != null) {
            // String name = data.getExtra("name");
            // String addr = data.getExtra("address");
            // String phone = data.getExtra("phone");
            // String email = data.getExtra("email");
            System.out.println(data);

        }
    }
}
