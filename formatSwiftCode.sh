#!/bin/bash -e

set -e

function checkCommand {
	commandName="${1}"
	commandLocation=""

	if ! commandLocation="$(type -p "$commandName")" || [[ -z $commandLocation ]]; then
		echo "Please install ${commandName}..."
		exit 0
	fi
}

checkCommand swiftlint
checkCommand swiftformat

swiftformat Example/LocalizeExample/Sources Sources --cache ignore --indent 4 \
--self insert \
--wrapcollections beforefirst --wraparguments beforefirst \
--comments ignore --commas inline \
--disable blankLinesAroundMark,hoistPatternLet,redundantParens,redundantVoidReturnType,trailingClosures

swiftlint autocorrect

git add .

echo "Formatting done..."
