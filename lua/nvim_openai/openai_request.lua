local M = {}

function M.api_call(api_key, model, prompt)
    local command=string.format([[
        curl -s https://api.openai.com/v1/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer %s" \
        -d '{"model": "%s", "prompt": "%s", "temperature": 0, "max_tokens": 100}'
        ]], api_key, model, prompt)

    local output = io.popen(command)
    local output = output:read('*a')

    -- start, stop, match = string.find(output, '"text":(.+)","index"')
    start, stop, match = string.find(output, [["text":"\n\n(.+)","index"]])

    return match

end

function M.gpt3_api_call(api_key, prompt)
    local command=string.format([[
        curl -s https://api.openai.com/v1/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer %s" \
        -d '{"model": "text-davinci-003", "prompt": "%s", "temperature": 0.5, "max_tokens": 2048}'
        ]], api_key, prompt)

    local output = io.popen(command)
    local output = output:read('*a')

    -- start, stop, match = string.find(output, '"text":(.+)","index"')
    start, stop, match = string.find(output, [["text":"[\?]?\n\n(.+)","index"]])

    return match
end

function M.chat_gpt_api_call(api_key, prompt)
    local command=string.format([[
        curl -s https://api.openai.com/v1/images/generations \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer %s" \
        -d '{"model": "chatbot", "prompt": "%s"}'
        ]], api_key, prompt)

    local output = io.popen(command)
    local output = output:read('*a')

    -- start, stop, match = string.find(output, '"text":(.+)","index"')
    start, stop, match = string.find(output, [["text":"\n\n(.+)","index"]])

    return match
end


return M
