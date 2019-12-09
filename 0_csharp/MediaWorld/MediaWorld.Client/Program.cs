using System;
using MediaWorld.Domain.Models;
using MediaWorld.Domain.Abstracts;
using MediaWorld.Domain.Singletons;
using MediaWorld.Domain.Factories;
using MediaWorld.Storing.Repositories;
using Serilog;

namespace MediaWorld.Client
{
  /// <summary>
  /// contains the start point
  /// </summary>
  internal class Program
  {
    /// <summary>
    /// starts the application
    /// </summary>
    /// <param name="args"></param>
    private static MediaRepository _repository = new MediaRepository();  // or instaniate it inside the class
    private static void Main(string[] args)
    {
      // var helper = MediaPlayerSingleton.GetInstance();
      // Console.WriteLine(helper);

      // DisplayMusic();

      Play();
    }


    // private static void DisplayMusic()
    // {
    //   var m = new Song();
    //   Console.WriteLine(m.Artist);
    //   var audible = new Audible();
    //   // audible.Speaker = "Author";
    //   Console.WriteLine(audible.Speaker);
    // }
    private static void Play()
    {
      // var mediaPlayer = MediaPlayerSingleton.Instance;
      // AMedia song = new Song();
      // AMedia movie = new Movie();
      // var audioFactory = new AudioFactory();
      // AMedia song_1 = audioFactory.Create<Song>();


      var mediaPlayer = MediaPlayerSingleton.Instance;

      // foreach(var items in _repository.MediaLibrary)
      // {
      //   mediaPlayer.Execute("play", item);
      // }

      // mediaPlayer.Execute("play", song);
      // mediaPlayer.Execute("play", movie);

      foreach (var item in _repository.MediaLibrary)
      {
        mediaPlayer.Execute(item.Play);
      }
    }
  }
}
