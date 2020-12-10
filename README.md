# TriforkSwiftLogger

## Motivation

TriforkSwiftLogger is a lightweight logging framework which defines a set of protocols and provides the ability to log with multiple loggers. The framework itself contains a `OSLogger` which can be used out of the box to log through Apple's `os.log` module. The logger protocols uses a defined set of logging levels to control logs for different configurations. 

## Installation ⬇️

Add `https://github.com/trifork/TriforkSwiftLogger.git` to your Xcode project file and start using `OSLogger`

## Configuration
You can customize the default configuration for the logger by setting the `config` parameter. You can also mutate the default config by setting a single parameter on the `OSLoggerConfig` object.

## MultiLogger
You can implement multiple `LoggerProtocol` classes and initialize a `MultiLogger` with multiple logger. The `MultiLogger` will invoke all loggers when logging.

**NOTE:** The `MultiLogger` does not have any configurations. It is up to the  `LoggerProtocol` implementation to handle the behaviour of the different logging functions.

## Log
```
let logger = OSLogger()
logger.debug("Hello!", category: "my-custom-category")
logger.default("Hello!")
logger.info("Hello!")
logger.error("Hello!")
logger.fault("Hello!")

let multiLogger = MultiLogger(loggers: [OSLogger(), MyCustomLogger()])
multiLogger.info("Hello!", category: "my-custom-category") // the info-function will be invoked for both OSLogger and MyCustomLogger.
```

---

<p align="center">
  <img width="220" height="44" src="https://trifork.com/wp-content/uploads/2018/06/Trifork_payoff_logo_RGB.png" alt="TRIFORK">
</p>
