function pds_export_figure(figHandle, filePath)
% Exporta figura em PNG com qualidade para relatorios academicos.

  marginFraction = 0.08;

  if nargin < 1 || isempty(figHandle)
    figHandle = gcf;
  end

  if nargin < 2 || isempty(filePath)
    error('Informe o caminho de saida para a figura.');
  end

  [folderPath, baseName, extension] = fileparts(filePath);
  if isempty(extension)
    extension = '.png';
  end
  if isempty(folderPath)
    folderPath = '.';
  end
  if ~exist(folderPath, 'dir')
    mkdir(folderPath);
  end

  pngPath = fullfile(folderPath, [baseName extension]);
  set(figHandle, 'Color', 'white');
  set(figHandle, 'PaperPositionMode', 'auto');

  axesHandles = findall(figHandle, 'Type', 'axes');
  for idx = 1:numel(axesHandles)
    axisHandle = axesHandles(idx);
    try
      axisTag = get(axisHandle, 'Tag');
      if ischar(axisTag) && strcmpi(axisTag, 'legend')
        continue;
      end

      currentXLim = get(axisHandle, 'XLim');
      currentYLim = get(axisHandle, 'YLim');
      if isvector(currentXLim) && numel(currentXLim) == 2 && all(isfinite(currentXLim))
        xPad = pds_compute_padding(currentXLim, marginFraction);
        set(axisHandle, 'XLim', [currentXLim(1) - xPad, currentXLim(2) + xPad]);
      end
      if isvector(currentYLim) && numel(currentYLim) == 2 && all(isfinite(currentYLim))
        yPad = pds_compute_padding(currentYLim, marginFraction);
        set(axisHandle, 'YLim', [currentYLim(1) - yPad, currentYLim(2) + yPad]);
      end

      tightInset = get(axisHandle, 'TightInset');
      set(axisHandle, 'LooseInset', tightInset + [0.01 0.01 0.01 0.01]);
    catch
    end
  end

  drawnow;
  print(figHandle, '-dpng', '-r300', pngPath);
end

function padValue = pds_compute_padding(axisLimits, marginFraction)
  axisRange = axisLimits(2) - axisLimits(1);
  if axisRange > 0
    padValue = marginFraction * axisRange;
  else
    padValue = marginFraction * max(1, abs(axisLimits(1)));
  end
end
