package me.thenightmancodeth.cepheus

import android.graphics.Color
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import kotlinx.android.synthetic.main.activity_main.*
import java.io.DataOutputStream


class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        toggle_button.setOnClickListener { runScript() }
    }

    fun runScript() {
        val p = Runtime.getRuntime().exec("su")
        val dos = DataOutputStream(p.outputStream)

        dos.writeBytes("sh /sdcard/Download/test.sh\n")
        dos.flush()

        dos.writeBytes("exit\n")
        dos.flush()
        dos.close()
        p.waitFor()
        if (p.exitValue() != 255) {
            // Root access was granted and the script was executed successfully
            Toast.makeText(this, "Andromeda successfully started", Toast.LENGTH_LONG)
                    .show()
            toggle_button.setBackgroundColor(Color.RED)
        } else {
            Toast.makeText(this, "Cephus needs root access to work!", Toast.LENGTH_LONG)
                    .show()
        }
    }
}
