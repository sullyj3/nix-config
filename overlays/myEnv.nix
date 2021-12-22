self: super: {
  myEnv = super.buildEnv {
    name = "myEnv";
    paths = [
      # A Python 3 interpreter with some packages
      (self.python310.withPackages (
        ps: with ps; [
          numpy
        ]
      ))

      # Some other packages we'd like as part of this env
      self.mypy
      self.black
    ];
  };
}
