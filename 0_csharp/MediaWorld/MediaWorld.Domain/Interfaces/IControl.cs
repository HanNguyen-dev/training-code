
namespace MediaWorld.Domain.Interfaces {

  public interface IControl {
    bool Play();
    bool Pause();
    bool Forward();
    bool Rewind();
    bool Stop();
  }
}