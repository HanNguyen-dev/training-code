using System.Collections.Generic;
using MediaWorld.Domain.Abstracts;
using MediaWorld.Domain.Factories;
using MediaWorld.Domain.Models;


namespace MediaWorld.Storing.Repositories
{
  public class MediaRepository
  {
    private List<AMedia> _mediaLibrary = new List<AMedia>();
    private List<AMedia> MediaRepository = new List<AMedia>();
    public MediaRepository()
    {
      Initialize();
    }
    public List<AMedia> Initialize()
    {
      var audioFactory = new AudioFactory();
      var videoFactory = new VideoFactory();


      if (_mediaLibrary == null) // might be run again
      {
        _mediaLibrary = new List<AMedia>();

        _mediaLibrary.AddRange(new AMedia[]{
          audioFactory.Create<Book>(),
          audioFactory.Create<Song>(),
          videoFactory.Create<Movie>(),
          videoFactory.Create<Photo>()

        });
      }
      return _mediaLibrary;
    }
  }
}