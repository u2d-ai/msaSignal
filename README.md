<p align="center">
  <img src="http://logos.u2d.ai/msaSignal_logo.png?raw=true" alt="msaSignal Logo"/>
</p>

------
<p align="center">
    <em>msaSignal - Signals/Events for Starlette/FastAPI.</em>
<br>
<em>Signals/Events for Starlette/FastAPI. Run background task without blocking the function that creates the signal. 
msaSDK.signals tries to stay as a background task runner.</em>
<br>
  <a href="https://pypi.org/project/msaSignal" target="_blank">
      <img src="https://img.shields.io/pypi/v/msaSignal?color=%2334D058&label=pypi%20package" alt="Package version">
  </a>
  <a href="https://pypi.org/project/msaSignal" target="_blank">
      <img src="https://img.shields.io/pypi/pyversions/msaSignal.svg?color=%2334D058" alt="Supported Python versions">
  </a>
</p>

------


**Documentation**: <a href="https://msaSignal.u2d.ai/" target="_blank">msaSignal Documentation (https://msaSignal.u2d.ai/)</a>



## Features
- **Middleware**: for Signal or Task.
- **Decorators**: for signal registry
- **Helpers**: for Handler, initiate a Signalor a Task


## Main Dependencies

- Starlette 0.20.x


# Usage - MSASignalMiddleware
!!! note
    Only one signal per function, must take request object as arg

### Add middleware
```python
from msaSignal import MSASignalMiddleware, signal
from fastapi import FastAPI

app = FastAPI()
app.add_midleware(MSASignalMiddleware, handler=signal)

# OR enable MSASetting for this feature (settings.signal_middleware)
```
### Add handler
Specify how the fired signal should work.
```python
from msaSignal import signal
import asyncio

@signal.register
async def handler(**kwargs):
    await asyncio.sleep(5)
    print(kwargs)
    print('Works!')
```
### Fire signal in function
!!! note
    Only one signal call is allowed using background task.

```python
from msaSignal import initiate_signal
@app.get("/")
async def endpoint(request: Request):
    await initiate_signal(request, 'handler',some_data="test value")
    return {"status":"Success"}
```
# Usage - MSATaskMiddleware
Any number of tasks, no request object needed.
### Add middleware
```python
from msaSignal import MSATaskMiddleware
from fastapi import FastAPI
app = FastAPI()
app.add_midleware(MSATaskMiddleware)

# OR enable MSASetting for this feature (settings.task_middleware)
```
### Write handler
Specify how the fired task should work.
```python
async def handler():
    await asyncio.sleep(5)
    print('Works!')
```
### Fire task in function
```python
from msaSignal import initiate_task
@app.get("/")
async def endpoint():
    await initiate_task(handler,some_data="test value")
    return {"status":"Success"}
```
## License Agreement

- `msaSignal`Based on `MIT` open source and free to use, it is free for commercial use, but please show/list the copyright information about msaSignal somewhere.


## How to create the documentation

We use mkdocs and mkdocsstring. The code reference and nav entry get's created virtually by the triggered python script /docs/gen_ref_pages.py while ``mkdocs`` ``serve`` or ``build`` is executed.

### Requirements Install for the PDF creation option:
PDF Export is using mainly weasyprint, if you get some errors here pls. check there documentation. Installation is part of the msaSignal, so this should be fine.

We can now test and view our documentation using:

    mkdocs serve

Build static Site:

    mkdocs build


## Build and Publish
  
Build:  

    python setup.py sdist

Publish to pypi:

    twine upload dist/*
