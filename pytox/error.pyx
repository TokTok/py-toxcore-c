class UseAfterFreeException(Exception):
    def __init__(self):
        super().__init__(
                "object used after it was killed/freed (or it was never initialised)")

class ToxException(Exception):
    pass

class ApiException(ToxException):
    def __init__(self, err):
        super().__init__(err)
        self.error = err

class LengthException(ToxException):
    pass
