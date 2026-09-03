import os
from PIL import Image, ImageDraw, ImageFont

def render_terminal(title, text_lines, output_path, width=980):
    try:
        font = ImageFont.truetype('/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf', 13)
        bold_font = ImageFont.truetype('/usr/share/fonts/truetype/dejavu/DejaVuSansMono-Bold.ttf', 13)
    except:
        font = ImageFont.load_default()
        bold_font = font
        
    line_height = 20
    padding = 16
    header_height = 36
    total_height = header_height + (len(text_lines) * line_height) + (padding * 2)
    
    img = Image.new('RGB', (width, max(total_height, 180)), color='#1e1e1e')
    draw = ImageDraw.Draw(img)
    
    # Title bar
    draw.rectangle([(0, 0), (width, header_height)], fill='#2d2d2d')
    # Window controls
    draw.ellipse([(14, 12), (26, 24)], fill='#e95420')  # Close (Ubuntu orange)
    draw.ellipse([(34, 12), (46, 24)], fill='#888888')  # Minimize
    draw.ellipse([(54, 12), (66, 24)], fill='#555555')  # Maximize
    
    # Title text
    draw.text((78, 10), title, fill='#dfdbd2', font=font)
    
    y = header_height + padding
    for line in text_lines:
        if line.startswith('moneca@') or line.startswith('$ '):
            draw.text((padding, y), line, fill='#8ae234', font=bold_font)
        elif line.startswith('#'):
            draw.text((padding, y), line, fill='#729fcf', font=font)
        elif line.startswith('>') or line.startswith('===') or line.startswith('---'):
            draw.text((padding, y), line, fill='#fce94f', font=bold_font)
        elif 'error' in line.lower() or 'failed' in line.lower() or 'no such file' in line.lower():
            draw.text((padding, y), line, fill='#ef2929', font=font)
        elif line.startswith('CONTAINER ID') or line.startswith('Filesystem') or line.startswith('USER'):
            draw.text((padding, y), line, fill='#34e2e2', font=bold_font)
        else:
            draw.text((padding, y), line, fill='#eeeeec', font=font)
        y += line_height
        
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    img.save(output_path)
    print(f'Rendered: {output_path}')

def render_browser(url, body_text, output_path, width=900, height=350):
    try:
        font = ImageFont.truetype('/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf', 14)
        heading_font = ImageFont.truetype('/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf', 24)
        url_font = ImageFont.truetype('/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf', 12)
    except:
        font = ImageFont.load_default()
        heading_font = font
        url_font = font

    img = Image.new('RGB', (width, height), color='#ffffff')
    draw = ImageDraw.Draw(img)

    # Browser chrome header
    draw.rectangle([(0, 0), (width, 70)], fill='#202124')
    # Window buttons
    draw.ellipse([(15, 15), (25, 25)], fill='#ed6a5f')
    draw.ellipse([(35, 15), (45, 25)], fill='#f5bf4f')
    draw.ellipse([(55, 15), (65, 25)], fill='#62c554')

    # Address bar
    draw.rounded_rectangle([(100, 36), (width - 40, 62)], radius=12, fill='#303134')
    draw.text((120, 42), f'🔒 {url}', fill='#9aa0a6', font=url_font)

    # Web page body
    draw.text((50, 130), body_text, fill='#202124', font=heading_font)

    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    img.save(output_path)
    print(f'Rendered Browser: {output_path}')
