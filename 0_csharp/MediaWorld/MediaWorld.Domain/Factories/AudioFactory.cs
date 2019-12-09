using MediaWorld.Domain.Interfaces;
using MediaWorld.Domain.Models;
using MediaWorld.Domain.Abstracts;
using System;


namespace MediaWorld.Domain.Factories
{
  public class AudioFactory : IFactory
  {
    public AMedia Create<T>() where T : AMedia, new()
    {
      return new T() as AMedia;
    }

    // public AMedia Create(Type type)
    // {
    //   switch (type)
    //   {
    //     case "book":
    //       return new Book();
    //     case "song":
    //       return new Song();
    //     default:
    //       return null;
    //   }
    // }
  }
}