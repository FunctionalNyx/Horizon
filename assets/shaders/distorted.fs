
#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif

extern PRECISION vec2 distorted;
extern PRECISION number dissolve;
extern PRECISION number time;
extern PRECISION vec4 texture_details;
extern PRECISION vec2 image_details;
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv);

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec2 uv = (
        texture_coords * image_details
        - texture_details.xy * texture_details.ba
    ) / texture_details.ba;

    // Amplitude and frequency controls
    float amplitude = 0.025 * max(distorted.x, 0.2);
    float frequency = 35.0;
    float t = distorted.y;

    // Animated horizontal and vertical waves
    float wave_x = sin(uv.y * frequency + t * 2.0)
        + 0.45 * sin(uv.y * frequency * 2.1 - t * 2.8);

    float wave_y = sin(uv.x * frequency * 0.8 - t * 2.4)
        + 0.35 * sin(uv.x * frequency * 1.7 + t * 2.0);

    // Convert the local distortion into atlas coordinates FUCK YOU ! ! ! !
    vec2 warped_coords = texture_coords;

    warped_coords.x += wave_x * amplitude
        * texture_details.b / image_details.x;

    warped_coords.y += wave_y * amplitude * 0.5
        * texture_details.a / image_details.y;

    vec4 tex = Texel(texture, warped_coords);

    return dissolve_mask(tex * colour, texture_coords, uv);
}

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(
            shadow ? vec3(0.0) : tex.xyz,
            shadow ? tex.a * 0.3 : tex.a
        );
    }

    float adjusted_dissolve =
        dissolve * dissolve * (3.0 - 2.0 * dissolve) * 1.02 - 0.01;

    float t = time * 10.0 + 2003.0;

    vec2 floored_uv = floor(uv * texture_details.ba)
        / max(texture_details.b, texture_details.a);

    vec2 centered = (floored_uv - 0.5) * 2.3
        * max(texture_details.b, texture_details.a);

    vec2 p1 = centered + 50.0
        * vec2(sin(-t / 143.634), cos(-t / 99.4324));

    vec2 p2 = centered + 50.0
        * vec2(cos(t / 53.1532), cos(t / 61.4532));

    vec2 p3 = centered + 50.0
        * vec2(sin(-t / 87.53218), sin(-t / 49.0));

    float field = (1.0 + (
        cos(length(p1) / 19.483)
        + sin(length(p2) / 33.155) * cos(p2.y / 15.73)
        + cos(length(p3) / 27.193) * sin(p3.x / 21.92)
    )) / 2.0;

    vec2 borders = vec2(0.2, 0.8);

    float res = 0.5 + 0.5 * cos(
        adjusted_dissolve / 82.612 + (field - 0.5) * 3.14
    );

    res -= max(floored_uv.x - borders.y, 0.0)
        * (5.0 + 5.0 * dissolve) * dissolve;

    res -= max(floored_uv.y - borders.y, 0.0)
        * (5.0 + 5.0 * dissolve) * dissolve;

    res -= max(borders.x - floored_uv.x, 0.0)
        * (5.0 + 5.0 * dissolve) * dissolve;

    res -= max(borders.x - floored_uv.y, 0.0)
        * (5.0 + 5.0 * dissolve) * dissolve;

    if (
        tex.a > 0.01 &&
        burn_colour_1.a > 0.01 &&
        !shadow &&
        res < adjusted_dissolve
            + 0.8 * (0.5 - abs(adjusted_dissolve - 0.5)) &&
        res > adjusted_dissolve
    ) {
        if (
            res < adjusted_dissolve
                + 0.5 * (0.5 - abs(adjusted_dissolve - 0.5))
        ) {
            tex = burn_colour_1;
        } else if (burn_colour_2.a > 0.01) {
            tex = burn_colour_2;
        }
    }

    return vec4(
        shadow ? vec3(0.0) : tex.xyz,
        res > adjusted_dissolve
            ? (shadow ? tex.a * 0.3 : tex.a)
            : 0.0
    );
}

extern PRECISION vec2 mouse_screen_pos;
extern PRECISION float hovering;
extern PRECISION float screen_scale;

#ifdef VERTEX
vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    if (hovering <= 0.0) {
        return transform_projection * vertex_position;
    }

    float mid_dist = length(
        vertex_position.xy - 0.5 * love_ScreenSize.xy
    ) / length(love_ScreenSize.xy);

    vec2 mouse_offset =
        (vertex_position.xy - mouse_screen_pos.xy) / screen_scale;

    float scale = 0.2
        * (-0.03 - 0.3 * max(0.0, 0.3 - mid_dist))
        * hovering
        * (length(mouse_offset) * length(mouse_offset))
        / (2.0 - mid_dist);

    return transform_projection * vertex_position
        + vec4(0.0, 0.0, 0.0, scale);
}
#endif

