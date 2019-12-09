using System;
using System.Collections.Generic;

namespace PizzaBox.Client.Models
{
  public class Pizza
  {
    // this the view model pizza
    // present the size, cheese, etc
    public int Crust { get; set; }
    public int Size { get; set; }
    public List<string> Crusts { get; set; }
    public List<string> Sizes { get; set; }

    public Pizza()
    {
      Crusts = new List<string> { "thin", "nystyle", "deepdish"};
      Sizes = new List<string> {"small", "medium", "large"};
    }

  }
}
