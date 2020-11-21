#!/bin/bash

##
## This file is part of the `powerline/fonts` project.
##
## (c) Rob Frawley 2nd <rmf@src.run>
##
## For the full copyright and license information, please view the LICENSE.md
## file that was distributed with this source code.
##


#
# output text using printf-style arguments
#

function out_text() {
    printf -- "${@}"
}


#
# output the number of newline passed on argument (defaults to 1)
#

function out_nl_n() {
    for i in $(seq 1 "${1:-1}"); do out_text '\n'; done
}


#
# output info line of text
#

function out_info() {
    1>&2 out_text "[FONT] ${1}" "${@:2}"
    1>&2 out_nl_n
}


#
# output info line of text
#

function out_fail() {
    1>&2 out_text "[FAIL] ${1}" "${@:2}"
    1>&2 out_nl_n
}


#
# escape path separators for regular expression
#
function get_path_escape_seps() {
    sed 's/\//\\\//g' <<< "${1}"
}


#
# escape path separators for regular expression
#
function get_path_double_seps_rm() {
    sed 's/\/\//\//g' <<< "${1}"
}


#
# escape path separators for regular expression
#
function get_file_replace_spaces() {
    sed 's/ /-/g' <<< "${1}"
}


#
# resolve a path (expanding path and dereferencing symbolic links) using the most accurate method available
#

function get_real_path() {
    local inpt_path="${1}"
    local full_path="$(
        cd "${inpt_path}" 2> /dev/null && \
        pwd 2> /dev/null
    )"
    local real_path="$(
        readlink -e "${full_path:-${inpt_path}}" 2> /dev/null || \
        realpath -e "${full_path:-${inpt_path}}" 2> /dev/null
    )"

    out_text "${real_path:-${full_path:-${inpt_path}}}"
}


#
# resolve the real directory path of this script
#

function get_self_path() {
    get_real_path "$(dirname "${BASH_SOURCE[0]}")"
}


#
# call sudo with custom password prompt
#

function get_sudo_prompt_text() {
    local -a msg_args=("${@}")

    if [[ ${#msg_args[@]} -eq 0 ]]; then
        msg_args+=("complete this operation")
    fi

    out_text "[SUDO] To %s privileges must be escalating to \"%%U\" by entering the password for \"%%p\": " "$(out_text "${@}")"
}


#
# create the passed path (resorting to sudo if required)
#

function make_path_reqd() {
    local reqd_path="${1}"

    mkdir -p "${reqd_path}" 2> /dev/null || \
        sudo -p "$(get_sudo_prompt_text 'create the new path "%s"' "${reqd_path}")" mkdir -p "${reqd_path}"

    if [[ ! -d "${reqd_path}" ]]; then
        out_fail 'Could not create required path "%s". Exiting...' "${reqd_path}"
        exit 1
    fi
}


#
# copy the origin file to the target file (as assigned by the first and second arguments)
#

function copy_file_req() {
    local origin_file="${1}"
    local target_file="${2}"
    local caller_opts='--remove-destination --dereference --no-target-directory'

    cp ${caller_opts} "${origin_file}" "${target_file}" 2> /dev/null || \
        sudo -p "$(get_sudo_prompt_text 'copy the new file "%s"' "${target_file}")" cp ${caller_opts} "${origin_file}" "${target_file}"

    if [[ ! -f "${target_file}" ]]; then
        out_fail 'Could not copy font file "%s" to "%s"!' "${origin_file}" "${target_file}"
        return 1
    fi
}


#
# return the first path that exists in argument list passed (defaulting to returning the first argument if none exist)
#

function get_existing_or_first_path() {
    local -a path_list=("${@}")
    local    path_retn="${1}"

    for p in "${path_list[@]}"; do
        if [[ -d ${p} ]] && [[ -w ${p} ]]; then
            path_retn="${p}"
            break
        fi
    done

    path_retn="$(get_path_double_seps_rm "${path_retn}")"

    if [[ ! -e "${path_retn}" ]]; then
        make_path_reqd "${path_retn}"
    fi

    out_text "${path_retn}"
}


#
# resolve the font installation/target path (for osx systems, re: darwin)
#

function get_target_path_osx() {
    get_existing_or_first_path "${HOME}/Library/Fonts"
}


#
# resolve the font installation/target path (for nix systems, re: linux)
#

function get_target_path_nix() {
    get_existing_or_first_path "${HOME}/.fonts" "${HOME}/.local/share/fonts"
}


#
# resolve the font installation/target path
#

function get_target_path() {
    if [[ -n ${INSTALL_FONT_ROOT_PATH} ]]; then
        out_text "$(get_path_double_seps_rm "$(eval printf -- "${INSTALL_FONT_ROOT_PATH}")")"
        return
    fi

    case "$(uname)" in
        Darwin) get_target_path_osx || return 1 ;;
        Linux)  get_target_path_nix || return 1 ;;
    esac
}


#
# resolve the font type (truetype, opentype, etc) using the file extension (for double-extension types)
#

function try_get_double_font_file_type_desc() {
    local file_extn="$(basename "${1}")"

    case "$(grep -oE '(\.[^\.]+)?\.[^\.]+$' <<< "${file_extn}" 2> /dev/null)" in
        .pcf.gz) out_text 'pcf' ;;
    esac
}


#
# resolve the font type (truetype, opentype, etc) using the file extension
#

function get_font_file_type_desc() {
    local file_name="$(basename "${1}")"

    case ".${file_name##*.}" in
        .ttf ) out_text 'truetype' ;;
        .otf ) out_text 'opentype' ;;
        *    ) out_text "$(try_get_double_font_file_type_desc "${file_name}")" ;;
    esac
}


#
# resolve the font family using the file path
#

function get_font_file_faml_desc() {
    local font_path="${1/$(get_path_escape_seps "${2:-}")/}"

    grep -oE '[^\/]+' <<< "$(
        grep -oE '^\/?[^\/]+' <<< "${font_path}" 2> /dev/null
    )" 2> /dev/null
}


#
# perform the font file installation
#

function do_install_font_file() {
    local font_target_inpt_path="${1}"
    local font_source_full_path="${2}"
    local self_script_full_path="${3}"
    local font_source_base_path="$(dirname "${font_source_full_path}")"
    local font_source_file_name="$(basename "${font_source_full_path}")"
    local font_source_font_faml="$(get_font_file_faml_desc "${font_source_full_path}" "${self_script_full_path}")"
    local font_source_font_type="$(get_font_file_type_desc "${font_source_full_path}")"
    local font_target_file_name="$(get_file_replace_spaces "${font_source_file_name}")"
    local font_target_root_path="$(get_path_double_seps_rm "${font_target_inpt_path}/${font_source_font_type}/${font_source_font_faml}")"
    local font_target_full_path="$(get_path_double_seps_rm "${font_target_root_path}/${font_target_file_name}")"

    out_text '[font] family => "%s"\n       type   => "%s"\n       origin => "%s"\n       target => "%s"\n       action => "copying"\n       result => ' \
        "${font_source_font_faml}" \
        "${font_source_font_type}" \
        "${font_source_full_path}" \
        "${font_target_full_path}"

    if [[ ! -d ${font_target_root_path} ]]; then
        make_path_reqd "${font_target_root_path}"
    fi

    if copy_file_req "${font_source_full_path}" "${font_target_full_path}"; then
        out_text '"successfully completed"'
    else
        out_text '"failure encountered"'
    fi

    out_nl_n 2
}


#
# perform the font installation for the passed font type filter
#

function do_install_font_sets() {
    local root_dest="${1}"
    local font_type="${2:-*}"
    local base_path="$(get_self_path)"

    find "${base_path}" \( \
            \( -iname "${font_type}*.[ot]tf"    -or -iname "${font_type}*.pcf.gz"    \) -or \
            \( -ipath "*${font_type}*/*.[ot]tf" -or -ipath "*${font_type}*/*.pcf.gz" \) \
        \) -type f -print0 2> /dev/null | \
    while IFS= read -r -d '' font_file; do
        do_install_font_file "${root_dest}" "${font_file}" "${base_path}" || break
    done
}


#
# main function loops over passed font type filters, passing the target root path and font type to function
#

function main() {
    local font_types=("${@}")
    local root_fdest

    if ! root_fdest="$(get_target_path)"; then
        out_fail 'Could not resolve target font path for your system. This is most likely permissions related. Exiting...\n'
        exit 1
    fi

    for t in "${font_types[@]:-*}"; do
        do_install_font_sets "${root_fdest}" "${t}"
    done
}

# call main function to start!
main "${@}"
