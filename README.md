# TriforkSwiftLogger

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)

## Installation ⬇️

Add `https://github.com/trifork/TriforkSwiftLogger.git` to your Xcode project file and start using `TriforkLogger`

## Configuration
You can customize the default configuration for the logger by setting the `config` parameter. You can also mutate the default config by setting a single parameter on the `TriforkLoggerConfig` object.

## MultiLogger
You can implement multiple `LoggerProtocol` classes and initialize a `MultiLogger` with multiple logger. The `MultiLogger` will invoke all loggers when logging.

If you have a logger, that is doing heavy load and prefers to be invoked on background thread, you can implement `AsyncLoggerProtocol` instead of the `Logger` protocol.

**NOTE:** The `MultiLogger` does not have any configurations. It is up to the  `LoggerProtocol` implementation to handle the behaviour of the different logging functions.

## Log
```
let logger = TriforkLogger()
logger.debug("Hello!", category: "my-custom-category")
logger.default("Hello!")
logger.info("Hello!")
logger.error("Hello!")
logger.fault("Hello!")

let multiLogger = MultiLogger(loggers: [TriforkLogger(), MyCustomLogger()])
multiLogger.info("Hello!", category: "my-custom-category") // the info-function will be invoked for both TriforkLogger and MyCustomLogger.
```

---

<p align="center">
  <img width="220" height="44" src="https://trifork.com/wp-content/uploads/2018/06/Trifork_payoff_logo_RGB.png" alt="TRIFORK">
</p>
