// http://www.scala-sbt.org/1.0/docs/Global-Settings.html

addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "latest.[0.8.2]")

//addSbtPlugin("com.typesafe.sbt" % "sbt-git" % "0.8.5")

//libraryDependencies += "com.typesafe.sbt" % "sbt-git" % "0.8.5"
//libraryDependencies += "org.slf4j" % "slf4j-nop" % "1.7.21"

//libraryDependencies += "com.lihaoyi" % "ammonite-repl" % "0.8.0" % "test" cross CrossVersion.full
//initialCommands in (Test, console) := """ammonite.repl.Repl.run("")"""

//Clean on every trigger
triggeredMessage in ThisBuild := Watched.clearWhenTriggered

// When you run an application from SBT and hit CTRL-C it, it normally quits to your OS. Following prevents:
cancelable in Global := true

initialize ~= { _ =>
  val ansi = System.getProperty("sbt.log.noformat", "false") != "true"
  if (ansi) System.setProperty("scala.color", "true")
}