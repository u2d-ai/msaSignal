# msaSignal

Signals/Events for Starlette/FastAPI.

## Usage

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
