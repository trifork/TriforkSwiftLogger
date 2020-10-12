# TriforkSwiftLogger

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)

## Installation ⬇️

Add `https://github.com/trifork/TriforkSwiftLogger.git` to your Xcode project file and start using `TriforkLogger`

## Configuration
You can customize the default configuration for the logger by setting the `config` parameter. You can also mutate the default config by setting a single parameter on the `TriforkLoggerConfig` object.

### Listener
You can implement a `TriforkLoggerListener` and hand set it in the configuration. The listener will be invoked every time there is a relevant log messge. This can be useful for posting error log messages to the cloud.

## Log
```
TriforkLogger.debug("Hello!", category: "my-custom-category")
TriforkLogger.default("Hello!")
TriforkLogger.info("Hello!")
TriforkLogger.error("Hello!")
TriforkLogger.fault("Hello!")
```

---

<p align="center">
  <img width="220" height="44" src="https://trifork.com/wp-content/uploads/2018/06/Trifork_payoff_logo_RGB.png" alt="TRIFORK">
</p>
