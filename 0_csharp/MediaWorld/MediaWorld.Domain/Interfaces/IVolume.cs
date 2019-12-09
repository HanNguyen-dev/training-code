
namespace MediaWorld.Domain.Interfaces {

  public interface IVolume : IControl
  {
    bool VolumeUp();
    bool VolumeDown();
    bool VolumeMute();
  }
}