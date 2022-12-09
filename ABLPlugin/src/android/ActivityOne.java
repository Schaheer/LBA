
package cordova.plugin.abl;

import com.example.abl.R;
import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;
import android.widget.EditText;
import android.widget.CheckBox;
import android.widget.Button;
import android.view.View;
import android.view.View.OnClickListener;
import android.content.Intent;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;

public class ActivityOne extends Activity {

    private Context context = this;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        String package_name = getApplication().getPackageName();
        setContentView(getApplication().getResources().getIdentifier("activity_one", "layout", package_name));
    }

    /*** Button Listeners ***/

}