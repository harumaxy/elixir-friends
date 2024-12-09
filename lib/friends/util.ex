defmodule Friends.Util do
  defmacro t?(boolean, on_true, on_false) do
    quote do
      if unquote(boolean) do
        unquote(on_true)
      else
        unquote(on_false)
      end
    end
  end
end
