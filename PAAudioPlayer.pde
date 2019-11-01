import android.media.AudioManager;
import android.media.MediaPlayer;
import android.os.Environment;

class PAAudioPlayer extends MediaPlayer {
  PAAudioPlayer() {
  }

  boolean loadFile(String fileName) {
    String fullPath = Environment.getExternalStorageDirectory().getAbsolutePath();
    fullPath += "/" + fileName;
    return loadFileFullPath(fullPath);
  }

  boolean loadFileFullPath(String fileName) {
    println("PAAudioPlayer: loading <" + fileName + ">");
    try {
      this.setDataSource(fileName);
      this.setAudioStreamType(AudioManager.STREAM_MUSIC);    // Selects the audio strema for music/media
      this.prepare();
      println("Loaded OK");
      return true;
    } 
    catch (IOException e) {
      println("PAAudioPlayer: error preparing player\n" + e.getMessage());
      return false;
    }
  }
  
  void reStart() {
    if (this.isPlaying()) {
      this.seekTo(0);
    }
    this.start();
  }
}
